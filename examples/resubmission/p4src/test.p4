#define NUMPORTS            3

header_type ethernet_t {
    fields {
        dstAddr         :   48;
        srcAddr         :   48;
        etherType       :   16;
    }
}

header_type intrinsic_metadata_t {
    fields {
        mcast_grp       :   4;
        egress_rid      :   4;
        mcast_hash      :   16;
        lf_field_list   :   32;
        resubmit_flag   :   16;
    }
}

header_type mymetadata_t{
    fields{
        calport         :   8;
    }
}

field_list resubmit_FL {
    standard_metadata;
    mymetadata;
}

parser start {
    return parse_ethernet;
}

header ethernet_t ethernet;
metadata intrinsic_metadata_t intrinsic_metadata;
metadata mymetadata_t mymetadata;

parser parse_ethernet {
    extract(ethernet);
    return ingress;
}

action _drop() {
    drop();
}

action _nop() {
}

action forward(port) {
    modify_field(standard_metadata.egress_spec, port);
}

action _resubmission(){
    add_to_field(mymetadata.calport, 1);
    resubmit(resubmit_FL);
}

table dmac {
    reads {
        ethernet.dstAddr                :   exact;
        mymetadata.calport              :   exact;
    }
    actions {
        forward;
    }
    size : 512;
}

table mcast_src_pruning {
    reads {
        standard_metadata.instance_type :   exact;
    }
    actions {_nop; _drop;}
    size : 1;
}

table _resubmit_table{
    reads{
        mymetadata.calport              :   exact;
    }
    actions{
        _nop;
        _resubmission;
    }
    size : 128;
}

control ingress {
    apply(dmac);
    if(mymetadata.calport < NUMPORTS and ethernet.dstAddr == 0xffffffffffff){
        apply(_resubmit_table);
    }
}

control egress {
    if(standard_metadata.ingress_port == standard_metadata.egress_port) {
        apply(mcast_src_pruning);
    }
}
