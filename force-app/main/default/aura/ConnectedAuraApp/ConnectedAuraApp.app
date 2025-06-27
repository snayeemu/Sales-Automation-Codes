<aura:application extends="force:slds">
    <aura:attribute name="visible" type="boolean" default="false"/>
    <lightning:card>
        <lightning:button label="Connect" title="Connect" onclick="{! c.handleOpenModal }" class='slds-align_absolute-center'/>
    </lightning:card>
    
    <lightning:card class='slds-p-around_large' title="Accounts Info">
        <c:accountList/>
    </lightning:card>
    <lightning:card class='slds-p-around_large' title="Contacts Info">
        <c:contactList/>
    </lightning:card>
    <lightning:card class='slds-p-around_large' title="Opportunity Info">
        <c:opportunityList/>
    </lightning:card>
    <lightning:card class='slds-p-around_large' title="Connected Data">
        <c:ConnectedDataList/>
    </lightning:card>
    <lightning:card class='slds-p-around_large'>
        <c:connectedInputModal visible="{!v.visible}"/>
    </lightning:card>
</aura:application>