# The s3 bucket

resource "aws_s3_bucket" "static-resources" {
  tags = {
    Name = "Static resources containers"
  }
}

resource "aws_s3_bucket_policy" "allow_bucket_reading" {
  bucket = aws_s3_bucket.static-resources.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.bucket_reader.name}"
            },
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                aws_s3_bucket.static-resources.arn,
                "${aws_s3_bucket.static-resources.arn}/*"
            ]
        }
    ]
  })
}

resource "aws_s3_bucket_policy" "allow_bucket_writing" {
  bucket = aws_s3_bucket.static-resources.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.bucket_writer.name}"
      },
      "Action": "s3:*",
      "Resource": [
        aws_s3_bucket.static-resources.arn,
        "${aws_s3_bucket.static-resources.arn}/*"
      ]
    }]
  })
}