package game.battle.gui.hero
{
   import feathers.core.FeathersControl;
   
   public class BattleGUIHeroPanelGlowAnimation extends FeathersControl
   {
       
      
      private var _glow:Boolean = false;
      
      public function BattleGUIHeroPanelGlowAnimation()
      {
         super();
      }
      
      public function get glow() : Boolean
      {
         return _glow;
      }
      
      public function set glow(param1:Boolean) : void
      {
         if(_glow == param1)
         {
            return;
         }
         _glow = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
