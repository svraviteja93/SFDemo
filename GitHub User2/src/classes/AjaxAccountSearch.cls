public class AjaxAccountSearch {
    public string inputText{get; set;}
    public List<Account> accountList{get; set;}
    public boolean flag{get; set;}
    
    public AjaxAccountSearch(){
        flag = false;
    }

    public void searchAccount(){
        accountList = Database.query('select name, accountnumber from Account where name like '+'\''+inputText+'%'+'\'');
    }
}