import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import validateCredentials from '@salesforce/apex/CabCustomerController.validateCredentials';

export default class CustomeSignIn extends NavigationMixin(LightningElement) {
@track username='';
@track password='';

    handleUsernameChange(event){
        this.username=event.target.value;


        }

    handlePasswordChange(event){
        this.password=event.target.value;


        }
    handleLogin(){
        validateCredentials({
            username: this.username, password: this.password  })
            .then(result => {
                if(result){
                    let cmpDef = {
                        componentDef: "c:cabLwcWizard"
                    };
                    let encodedDef = btoa(JSON.stringify(cmpDef));
                    this[NavigationMixin.Navigate]({
                        type: "Standard_webpage",
                        attributes: {
                            url: "one/one.app#" + encodedDef
                        }
                    });

                    const toastEvent = new ShowToastEvent({
                        title: 'success',
                        message: 'Sign In Successfully',
                        variant: 'success',
                    });
                    this.dispacthEvnt(toastEvent);


                }else{
                    console.log(result)
                    const toastEvent = new ShowToastEvent({
                        title: 'Error',
                        message: 'Invalid Username or Password',
                        variant: 'error',
                    });
                    this.dispatchEvent(toastEvent);
                } 
                
                
            })
            .catch(error => {
                console.error(error);
                this.ShowToast('Error', 'An Error occurred', 'error');
            });

        

        }



}