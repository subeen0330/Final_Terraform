resource "aws_kms_key" "ebs_csi_driver_kms_key" {
  description             = "KMS key 1"
  deletion_window_in_days = 30
}