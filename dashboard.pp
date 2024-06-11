dashboard "aws_ec2_ami_dashboard" {
  title = "AWS EC2 AMI Details Dashboard"

  container {
    table {
      title = "AMI Details"
      sql = <<EOQ
        select
          'State' as label,
          initcap(state) as value
        from
          aws_ec2_ami
      EOQ
    }
  }
}
