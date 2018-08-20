package game.command.rpc.clan
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.model.user.Player;
   
   public class CommandClanUpdate extends CostCommand
   {
       
      
      private var title:String;
      
      private var description:String;
      
      private var news:String;
      
      private var country:int;
      
      private var minLevel:int;
      
      public function CommandClanUpdate(param1:String, param2:String, param3:int = 0, param4:int = 0)
      {
         super();
         rpcRequest = new RpcRequest("clanUpdate");
         this.description = param1;
         this.news = param2;
         this.country = param3;
         this.minLevel = param4;
         _cost = new CostData();
         if(param1)
         {
            rpcRequest.writeParam("description",param1);
         }
         if(param2 !== null)
         {
            rpcRequest.writeParam("news",param2);
         }
         if(param3)
         {
            rpcRequest.writeParam("country",param3);
         }
         if(param4)
         {
            rpcRequest.writeParam("minLevel",param4);
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(description)
         {
            param1.clan.clan.setDescription(description);
         }
         if(news)
         {
            param1.clan.clan.setNews(news);
         }
         if(country)
         {
            param1.clan.clan.setCountry(country);
         }
         if(minLevel)
         {
            param1.clan.clan.setMinLevel(minLevel);
         }
         super.clientExecute(param1);
      }
      
      override protected function successHandler() : void
      {
         if(result && result.body)
         {
            if(result.body.hasOwnProperty("news"))
            {
               news = result.body["news"];
            }
         }
         super.successHandler();
      }
   }
}
