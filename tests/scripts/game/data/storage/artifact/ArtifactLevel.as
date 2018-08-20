package game.data.storage.artifact
{
   import game.data.cost.CostData;
   
   public class ArtifactLevel
   {
       
      
      private var _level:uint;
      
      private var _color:String;
      
      private var _cost:CostData;
      
      private var _costStarmoney:CostData;
      
      public function ArtifactLevel(param1:int)
      {
         super();
         _level = param1;
      }
      
      public function get level() : uint
      {
         return _level;
      }
      
      public function get color() : String
      {
         return _color;
      }
      
      public function get cost() : CostData
      {
         return _cost;
      }
      
      public function get costStarmoney() : CostData
      {
         return _costStarmoney;
      }
      
      public function deserialize(param1:Object) : void
      {
         _color = param1.color;
         _cost = new CostData(param1.cost);
         _costStarmoney = new CostData(param1.starmoneyCost);
      }
   }
}
