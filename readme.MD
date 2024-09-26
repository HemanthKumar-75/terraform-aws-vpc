# Terraform AWS VPC Module Customized

this module is going to create the following resources.
for HA we are going to get first two AZ-zones

* VPC
* 2 public subnets
* 2 private subnets
* 2 database subnets
* Database subnet group
* EIP (Elastic IP)
* NAT Gateway
* Public Route table
* Private oute table
* Database Route table
* Routes
* Route table associations with subnets
* peering with default VPC (if required)
* Peering routes in acceptor and requstor route tables

# Inputs

* project_name (Mandatory)  : User must supply their project name.
* envinronment (Mandatory)  : User must supply their environment name.
* cidr_block (Mandatory)    : User must supply their VPC CIDR details.
* public_subnet_cidrblocks (Mandatory)  :  User must provide atleast 2 valid public CIDRs.
* private_subnet_cidrblocks (Mandatory)  :  User must provide atleast 2 valid private CIDRs.
* database_subnet_cidrblocks (Mandatory)  :  User must provide atleast 2 valid database CIDRs.
* common_tags (Optional)    : defaults to True.
* vpc_tags (Optional)       : default is empty. User can supply tags in list(string) format.
* igw_tags (Optional)       : default is empty. User can supply tags in list(string) format.
* public_subnet_tags (Optional) : default is empty. User can supply tags in list(string) format.
* private_subnet_tags (Optional) : default is empty. User can supply tags in list(string) format.
* database_subnet_tags (Optional) : default is empty. User can supply tags in list(string) format.
* nat_gateway_tags (Optional) : default is empty. User can supply tags in list(string) format.
* public_routes_tags (Optional) : default is empty. User can supply tags in list(string) format.
* private_routes_tags (Optional) : default is empty. User can supply tags in list(string) format.
* database_routes_tags (Optional) : default is empty. User can supply tags in list(string) format.
* NAT_tags (Optional) : default is empty. User can supply tags in list(string) format.
* is_peering_required (OPtional)    : defaults to false
* vpc_peering_tags (Optional)   : default is empty. User can supply tags in list(string) format. 

# Outputs

* vpc_id : VPC ID created