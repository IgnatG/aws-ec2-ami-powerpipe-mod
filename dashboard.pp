dashboard "aws_ec2_ami_dashboard" {
  title = "AWS EC2 AMI Details Dashboard"

  container {
    table {
      title = "AMI Details"
      sql = <<EOQ
        SELECT
          name AS label,
          image_id AS value,
          json_build_object('account_id', account_id, 'region', region) AS tags
        FROM
          aws_ec2_ami
        ORDER BY
          name;
      EOQ
    }
  }
}
