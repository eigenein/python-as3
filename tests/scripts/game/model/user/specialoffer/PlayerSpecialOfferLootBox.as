package game.model.user.specialoffer
{
   import game.data.cost.CostData;
   
   public class PlayerSpecialOfferLootBox
   {
       
      
      public var id:String;
      
      public var x1Cost:CostData;
      
      public var x10Cost:CostData;
      
      public var refillable:int;
      
      public var order:int;
      
      public function PlayerSpecialOfferLootBox(param1:String)
      {
         super();
         this.id = param1;
      }
      
      public function deserialize(param1:Object) : void
      {
         refillable = param1["refillable"];
         x1Cost = new CostData(param1["x1"]);
         x10Cost = new CostData(param1["x10"]);
         order = param1["order"];
      }
   }
}
