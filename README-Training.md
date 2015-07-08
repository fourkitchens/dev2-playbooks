# Setting up a new training server

tbd

# Setting up new users

Run the following command, replacing the ip with the IP for the server, the user_name with the student's username:
```bash
ansible-playbook -l 23.253.162.114 -i hosts deploy/students/student-add.yml -e "user_name=mike-test2 port=8001" -u root
```

# Managing students

To delete a student you can use the `deploy/users/user-delete.yml`
