package game.model.user.refillable
{
   import game.data.storage.refillable.RefillableDescription;
   
   public class PlayerEnergyRefillableEntry extends PlayerRefillableEntry
   {
       
      
      private var lvlSource:PlayerRefillableLevelSource;
      
      public function PlayerEnergyRefillableEntry(param1:Object, param2:RefillableDescription, param3:PlayerRefillableVIPSource, param4:PlayerRefillableLevelSource)
      {
         super(param1,param2,param3);
         this.lvlSource = param4;
      }
      
      override public function get maxValue() : int
      {
         return lvlSource.level.maxStamina;
      }
   }
}
