public class BatchTest implements Database.Batchable<sObject>{
    List<Account> accListToBEUpdated = new List<Account>();
    public Database.queryLocator start(Database.BatchableContext bc){        
        string query= 'Select Id,Name,AnnualRevenue From Account';
        return Database.getQueryLocator(query);
        
    }
    
    public void execute(Database.BatchableContext bc,List<Account> accList){
        for(Account acc : accList){
            if(acc.Annualrevenue > 100000){
                acc.Rating = 'Hot';
                accListToBEUpdated.add(acc);
                
            }
            if(!accListToBEUpdated.isEmpty()){
               Database.saveResult[] acList = Database.Insert(accListToBEUpdated, false); 
                
            
            for(Database.saveResult sc : acList){
                if(sc.isSuccess()){
                    System.debug(sc.getId());
                }
                else
                    for(Database.Error err : sc.getErrors()){
                    system.debug(err.getStatusCode()+'  '+err.getMessage());
                    System.debug(err.getFields());
                }
            }
            }
        }
        
    }
    
    public void finish(Database.BatchableContext bc){
        
    }
}