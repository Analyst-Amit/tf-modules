
resource "aws_iam_user" "my_iam_user" {
  name = "test-user"
}

# Creating a policy so that the test-user can assume this role
resource "aws_iam_policy" "assume_role_policy" {
  name        = "AssumeRolePolicy"
  description = "Policy to allow the user to assume a specific role"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "sts:AssumeRole",
        Resource = "arn:aws:iam::${var.AWS_ACCOUNT_ID}:role/ado-assume-role"  #Secure AWS account id.
      }
    ]
  })
}

# Attach the Policy to the User
resource "aws_iam_user_policy_attachment" "attach_assume_role_policy" {
  user       = aws_iam_user.my_iam_user.name 
  policy_arn = aws_iam_policy.assume_role_policy.arn
}



#Step1 Granting assume role policy for test-user
resource "aws_iam_role" "my_assume_role" {
  name = "ado-assume-role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          "AWS": "arn:aws:iam::${var.AWS_ACCOUNT_ID}:user/test-user" #Secure AWS account id.
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}
#step2: Grant Permission/Policy to this role
resource "aws_iam_role_policy_attachment" "my_assume_role_policy_attachment" {
  role       = aws_iam_role.my_assume_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  
}

#Now test-user is created.
#role "ado-assume-role" is created to be assumed by any users like test-users to perform tasks.
#Permissions have been granted to this role to access resources.