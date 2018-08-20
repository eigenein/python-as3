package game.data.storage.artifact
{
   import game.data.cost.CostData;
   
   public class ArtifactEvolutionStar
   {
       
      
      private var _star:uint;
      
      private var _costFragmentsAmount:uint;
      
      private var _battleEffectMultiplier:Number;
      
      private var _applyChancePercent:int;
      
      private var _costBase:CostData;
      
      public function ArtifactEvolutionStar()
      {
         super();
      }
      
      public function get star() : uint
      {
         return _star;
      }
      
      public function get costFragmentsAmount() : uint
      {
         return _costFragmentsAmount;
      }
      
      public function get battleEffectMultiplier() : Number
      {
         return _battleEffectMultiplier;
      }
      
      public function get applyChancePercent() : int
      {
         return _applyChancePercent;
      }
      
      public function get costBase() : CostData
      {
         return _costBase;
      }
      
      public function deserialize(param1:Object) : void
      {
         _star = param1.star;
         _costFragmentsAmount = param1.costFragmentsAmount;
         _battleEffectMultiplier = param1.battleEffectMultiplier;
         _applyChancePercent = param1.applyChancePercent;
         _costBase = new CostData(param1.costBase);
      }
   }
}
