dashboard "AWS EC2 AMI Details" {
  title = "AWS EC2 AMI Details Dashboard"

  container {
    table {
      title = "AMI Details"
      sql = <<EOQ
        WITH amis AS (
          SELECT
            image_id,
            name,
            state,
            owner_id,
            creation_date
          FROM
            aws_ec2_ami
        ),
        in_use_amis AS (
          SELECT
            DISTINCT image_id
          FROM
            aws_ec2_instance
          WHERE
            state IN ('running', 'pending', 'stopping', 'stopped')
        )
        SELECT
          a.image_id AS "AMI ID",
          a.name AS "AMI Name",
          a.state AS "AMI State",
          a.owner_id AS "Owner ID",
          a.creation_date AS "Creation Date",
          CASE
            WHEN iu.image_id IS NOT NULL THEN 'Yes'
            ELSE 'No'
          END AS "In Use"
        FROM
          amis a
          LEFT JOIN in_use_amis iu
          ON a.image_id = iu.image_id
        ORDER BY
          a.creation_date DESC;
      EOQ
    }
  }
}
