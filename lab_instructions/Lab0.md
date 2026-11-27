# Advanced Terraform on AWS — Lab 0

## Lab Setup

### Lab Objectives

In this lab, you will:

- Launch and configure Visual Studio Code (VSC) in your lab virtual machine ahead of running subsequent labs.
- Access AWS using provided credentials.

### Teaching Points

This lab will configure your lab environment. The environment has a time limit of 36 hours after which it will be decommissioned. Use the **Pause** option at the end of each day's training to ensure that the environment remains consistent for the entire duration of the course. If the lab expires, ends or is restarted, you may have to perform steps previously completed before progressing further.

### Before you begin

These instructions assume you have accessed the QA Portal and have followed the instructions provided there. You should have your remote lab desktop available before proceeding.

## Task 1 — Set up your Lab environment

1. Open VSC from the taskbar.
2. Verify that the **HashiCorp Terraform** and **VSCode-pdf** VSC extensions are installed.
3. Verify `C:\qatfadvaws` has been added to Explorer.

   These class files are available at <https://github.com/qatip/qatfadvaws.git> for post-class use.

## Task 2 — Logging into AWS

4. Open a new web browser tab and log in to the AWS Console using your provided lab credentials.

   **Note:** This can be done from your local machine or on the remote desktop. The latter is recommended.

5. When required to run Terraform commands from the VSC terminal, you will need to authenticate to AWS.
6. Type the following command in a terminal session:

   ```powershell
   aws configure
   ```

7. Use the **AWS Access Key ID** and **AWS Secret Access Key** provided in the lab portal.
8. Use **`us-west-2`** as your default region for this lab environment. If running these labs post-course, choose an appropriate region.
9. Leave Default output format blank.
10. These credentials are stored in `C:\Users\<username>\.aws`. You can re-run `aws configure` at any point to change these settings.

    The prompts will appear as follows (credential placeholders are illustrative):

    ```text
    AWS Access Key ID [None]: <provided access key ID>
    AWS Secret Access Key [None]: <provided secret access key>
    Default region name [None]: us-west-2
    Default output format [None]:
    ```

## Task 3 — Arranging your remote desktop

11. In order to avoid the frustration of desktop clutter, it is suggested you arrange your desktop so that you can easily switch between:

    - Your web browser, in which you can view your course manual, lab instructions, the AWS Console and any other web resources.
    - The VSC interface, in which you will create and action Terraform files.

    You can view the lab instructions within VSC or through a browser, browsing to `C:\qatfadvaws\lab_instructions`.

---

## Congratulations, you have completed this lab!

---

## Copyright

© 2026 QA Michael Coulling-Green. All rights reserved. These lab materials are provided as part of an authorised training course. Course attendees may reuse these materials for their own personal learning and reference outside of the training session. Unauthorised copying, redistribution, publication, or use of these materials to deliver training is prohibited without prior written permission from the author.

**Version:** 1.0.0  
**Date:** 28/06/26  
**Contact:** mcgreen@qa.com
