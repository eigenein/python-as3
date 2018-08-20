package game.battle.controller
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.NumberProperty;
   
   public class BattleSoundConfig
   {
       
      
      public var enabled:Boolean = true;
      
      public var volume:Number = 1;
      
      public var musicEnabled:BooleanProperty;
      
      public var musicVolume:NumberProperty;
      
      public function BattleSoundConfig(param1:BooleanProperty = null, param2:NumberProperty = null)
      {
         super();
         this.musicEnabled = param1;
         this.musicVolume = param2;
      }
   }
}
