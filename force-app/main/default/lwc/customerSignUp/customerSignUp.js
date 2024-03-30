import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class CustomerSignUp extends NavigationMixin(LightningElement) {
    @track showForm = false;

    handleSignUp(){
        this.showForm = true;


    }
    handleSignIn(){

        let cmpDef = { componentDef: "F:\Cab Booking\cabBooking\force-app\main\default\lwc\customeSignIn"};

        let encodedDef = btoa(JSON.stringify(cmpDef));
        this[NavigationMixin.Navigate]({
            type: "standard_webpage",
            attributes: { url: "one/one.app#" + encodedDef}
        });



    }


    handleSuccess(event){
        event.preventDefault();
        const toastEvent = new ShowToastEvent({
            title: 'Success',
            message: 'Sign Up Successfully !! Welcome To Premium Cab Services',
            variant: 'success',
        });
        this.dispatchEvent(toastEvent);

        let cmpDef ={ componentDef: "c:customeSignIn"};

        let encodedDef =  btoa(JSON.stringify(cmpDef));
        this[NavigationMixin.Navigate]({
            type: "standard_webpage",
            attributes: { url: "one/one.app#" + encodedDef}
        });


        


    }





}