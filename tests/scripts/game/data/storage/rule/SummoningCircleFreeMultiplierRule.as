package game.data.storage.rule
{
   public class SummoningCircleFreeMultiplierRule
   {
       
      
      private var _useMultiplierInTutorial:Boolean;
      
      private var _minTitanAmountToMultiply:int;
      
      private var _multiplierStep:int;
      
      private var _multiplierMax:int;
      
      public function SummoningCircleFreeMultiplierRule(param1:Object)
      {
         super();
         this._useMultiplierInTutorial = param1.useMultiplierInTutorial;
         this._minTitanAmountToMultiply = param1.minTitanAmountToMultiply;
         this._multiplierStep = param1.multiplierStep;
         this._multiplierMax = param1.multiplierMax;
      }
      
      public function get useMultiplierInTutorial() : Boolean
      {
         return _useMultiplierInTutorial;
      }
      
      public function get minTitanAmountToMultiply() : int
      {
         return _minTitanAmountToMultiply;
      }
      
      public function get multiplierStep() : int
      {
         return _multiplierStep;
      }
      
      public function get multiplierMax() : int
      {
         return _multiplierMax;
      }
   }
}
