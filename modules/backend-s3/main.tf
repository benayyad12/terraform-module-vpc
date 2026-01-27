resource "aws_s3_bucket" "s3_bkt" {
  bucket = "bucket-s3-backend-statetf-benayyad"
}
resource "aws_s3_bucket_versioning" "versioning_bkt" {
  bucket = aws_s3_bucket.s3_bkt.id
  versioning_configuration {
    status = "Enabled"
  }
}