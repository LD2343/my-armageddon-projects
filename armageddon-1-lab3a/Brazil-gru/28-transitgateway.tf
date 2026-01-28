
# # Explanation: gru is São Paulo’s Japanese town—local doctors, local compute, remote data.
# resource "aws_ec2_transit_gateway" "gru_tgw01" {
#   provider    = aws.sa_east_1
#   description = "gru-tgw01 (Sao Paulo spoke)"
#   tags = { Name = "gru-tgw01" }
# }

# # Explanation: gru accepts the corridor from Shinjuku—permissions are explicit, not assumed.
# resource "aws_ec2_transit_gateway_peering_attachment_accepter" "gru_accept_peer01" {
#   provider                      = aws.sa_east_1
#   transit_gateway_attachment_id = data.terraform_remote_state.japan.outputs.peering_attachment_id  # Read from Japan output (add this to Japan config if missing)
#   tags = { Name = "gru-accept-peer01" }
# }

# # Explanation: gru attaches to its VPC—compute can now reach Tokyo legally, through the controlled corridor.
# resource "aws_ec2_transit_gateway_vpc_attachment" "gru_attach_sp_vpc01" {
#   provider           = aws.sa_east_1
#   transit_gateway_id = aws_ec2_transit_gateway.gru_tgw01.id
#   vpc_id             = aws_vpc.gru_vpc01.id
#   subnet_ids         = [aws_subnet.gru_private_subnets[0].id, aws_subnet.gru_private_subnets[1].id]  # Use list elements; assumes 2 private subnets
#   tags = { Name = "gru-attach-sp-vpc01" }
# }