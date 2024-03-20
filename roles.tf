# Role management

# READER

resource "aws_iam_role" "bucket_reader" {
    name = "bucketreader"
    assume_role_policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow"
                "Principal": {
                    "Service": "ec2.amazonaws.com"
                }
                "Action": "sts:AssumeRole"
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "bucket_reader_attachment" {
    role = aws_iam_role.bucket_reader.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "bucket_reader_profile" {
    name = "bucket_reader_profile"
    role = aws_iam_role.bucket_reader.name
}

# WRITER

resource "aws_iam_role" "bucket_writer" {
  name = "bucketwriter"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "bucket_writer_attachment" {
  role = aws_iam_role.bucket_writer.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "bucket_writer_profile" {
  name = "bucket_writer_profile"
  role = aws_iam_role.bucket_writer.name
}