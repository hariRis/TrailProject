public class AccountController {
    public static void updateRelatedContacts(List<Account>accList,Map<Id,Account>oldMap){
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Contact> conlist = new List<Contact>();
        for(Account acc : accList){
            if(acc.Phone != null && acc.Phone != oldMap.get(acc.Id).Phone && oldMap != null){
                accMap.put(acc.Id,acc);
            }
        }   
        for(Contact con : [Select Id,Phone,AccountId From Contact where AccountId =: accMap.keyset()]){  
            if(accMap.containskey(con.AccountId)) {
                con.Phone = accMap.get(con.AccountId).Phone;
                conList.add(con);
            }   
        }
        if(!conList.isEmpty()){
            update conList;
        }
        
    }
    //If Account Rating is changed update Opportunity Descripion
    public static void UpdateAllOpportunities(List<Account> accList,Map<Id,Account>oldMap){
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Account acc : accList){
            if(acc.Rating != null && acc.Rating!= oldMap.get(acc.Id).Rating && oldMap != null){
                accMap.put(acc.Id,acc);
            }
        }
        
        for(Opportunity opp : [Select Id,Description,AccountId From Opportunity where AccountId IN : accMap.keyset()]){
            if(accMap.containskey(opp.AccountId)){
                opp.Description = accMap.get(opp.AccountId).Description;
                oppList.add(opp);
            }
        }
        if(!oppList.isEmpty()){
            try{
                update oppList;
            }catch(DmlException e){
                System.debug(e.getMessage());
            }
        }
    }
    
    public static void UpdateRating(List<Account> accList){
        for(Account acc : accList){
            if(acc.Rating == 'Hot'){
                acc.AnnualRevenue = 100001;
            }
        }
    }
    
    //Create Contacts on Account creation
    
    public static void CreateContacts(List<Account> accList){
        integer i;
        List<Contact> conList = new List<Contact>();
        for( i=0; i<5; i++){
            Contact con = new Contact();
            con.LastName = 'Test '+i;
            conList.add(con);
        }
            
    }
    
    
}