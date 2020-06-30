from diagrams import Cluster, Diagram, Edge
from diagrams.aws.compute import ECS
from diagrams.aws.network import VPC, PublicSubnet
from diagrams.oci.compute import ContainerGrey
from diagrams.oci.edge import Dns
from diagrams.onprem.inmemory import Hazelcast

graph_attr = {
    "fontsize": "30",
    "bgcolor": "transparent",
    "penwidth": "2.5",
    "pencolor": "'black'",
    "pad": "0.8",
    "fixedsize": "shape",
    "width": "10.0"
}

with Diagram("Hazelcast IMDG on ECS", show=False, graph_attr=graph_attr):
    dns = Dns("Internet")
    with Cluster("AWS"):
        vpc = VPC("VPC")
        public_subnet = PublicSubnet("Public Subnet")

        with Cluster("ECS"):
            ecs = ECS("Hazelcast Service")

            with Cluster("ECS Tasks / Containers"):
                node1 = Hazelcast("Node 1")
                node1ToNode2 = Edge(style="dotted")

                with Cluster("Optional multi-node support"):
                    node2 = Hazelcast("Node 2")
                    node3 = Hazelcast("Node n")
                    node2ToNode3 = Edge(style="dotted")

    node1 - node1ToNode2 - node2
    node2 - node2ToNode3 - node3
    dns >> vpc >> public_subnet >> node1