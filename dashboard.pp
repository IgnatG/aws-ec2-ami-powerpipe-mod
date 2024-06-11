dashboard "aws_ec2_ami_dashboard" {
  title = "AWS EC2 AMI Details Dashboard"

  container {
    table {
      title = "AMI Details"
      sql = <<EOQ
        select
          name as label,
          image_id as value,
          json_build_object('account_id', account_id, 'region', region) as tags
        from
          aws_ec2_ami
        order by
          title;
      EOQ
    }
  }
}
