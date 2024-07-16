# Deploy using Portainer
It is assumed that Docker and Portainer are already setup and working.
<br /><br />
There are two options for deployment using Portainer:
<br /><br />
## 1 - Deploy using Dockerfile via Portainer
This is for those who can't (or don't want to) use the pre-built images from Dockerhub. For example you may have an architecture for which there is no image on Dockerhub.
See this document for instructions: [INSTALLwPortDFile.md](INSTALLwPortDFile.md)
<br /><br />
## 2 - Deploy using docker-compose.yml via Portainer - recommended
This will be the preferred option for most people who are using Portainer. 
<br /><br />
i. Login to your Portainer instance. Select the Environment where the deployment will be made
<br /><br />
ii. Select the 'Volumes' link from the left menu. Click the blue '+ Add volume' button. In the Create volume page, enter `tesla_ble_mqtt` in the Name field and press the blue 'Create the volume' button:
<br /><br />
<img width="805" alt="image" src="https://github.com/user-attachments/assets/179f32b0-5df4-40ce-a836-8376bf49657b">
<br /><br />
iii. Select the 'Stacks' link from the left menu. Click the blue '+ Add Stack' button. In the 'Create stack' page, enter `tesla_ble_mqtt` in the Name field. Copy and Paste the contents of [docker-compose.yml](https://raw.githubusercontent.com/tesla-local-control/tesla_ble_mqtt_docker/main/docker-compose.yml) into the Web editor box:
<br /><br />
<img width="788" alt="image" src="https://github.com/user-attachments/assets/b0c318c3-df7c-498e-84aa-a547d577c073">
<br /><br />
iv. Scroll further down the Create stack page. In the Environment variables section press the blue Advanced Mode link:
<br /><br />
<img width="755" alt="image" src="https://github.com/user-attachments/assets/47b83be5-b52f-4cc5-8077-e50aafdd91cc">
<br /><br />
v. A box to enter environment variables will open up. Copy and Paste the contents of [stack.env](https://raw.githubusercontent.com/tesla-local-control/tesla_ble_mqtt_docker/main/stack.env) into the box, and press the blue 'Deploy the stack' button:
<br /><br />
<img width="714" alt="image" src="https://github.com/user-attachments/assets/cb09e093-3791-4fb4-bfea-07b0f7b2f821">
<br /><br />
vi. After some time, if all is well, the message 'Success. Stack successfully deployed' will briefly pop-up, and you will be returned to the 'Stacks list' page. Click the newly created tesla_ble_mqtt stack to enter the 'Stack details' page for the new stack. Click the red 'Stop this stack' button, then click the 'Editor' tab:
<br /><br />
![image](https://github.com/user-attachments/assets/92351402-e404-4926-b69e-c1420ed500a9)
<br /><br />
vii. Scroll down to the 'Environment variables' section. Enter the values required for your setup in the respective fields and when completed press the 'Update the stack' button. Use [stack.env](https://github.com/tesla-local-control/tesla_ble_mqtt_docker/blob/main/stack.env) as a reference
<br /><br />
![image](https://github.com/user-attachments/assets/a0a0f149-92ba-49e0-a8fa-b149983f9172)
<br /><br />
vii. If all is well, the message 'Success. Stack successfully deployed' will briefly pop-up, and you will be returned to the 'Stacks list' page. Click the tesla_ble_mqtt stack to enter the 'Stack details' page for the new stack. In the Containers section click the tesla_ble_mqtt container to enter the 'Container details' page. From here you can view the logs by pressing the Logs link in the 'Container status' section. Succesful logs look something like this at startup:
<br /><br />
![Screenshot 2024-07-15 180414](https://github.com/user-attachments/assets/065ece8f-2d91-4679-81be-12195fe89a81)



