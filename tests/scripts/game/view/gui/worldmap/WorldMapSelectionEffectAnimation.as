package game.view.gui.worldmap
{
   import engine.core.clipgui.GuiAnimation;
   
   public class WorldMapSelectionEffectAnimation extends GuiAnimation
   {
       
      
      private var _doubleSpeed:Boolean;
      
      public function WorldMapSelectionEffectAnimation()
      {
         super();
      }
      
      public function get doubleSpeed() : Boolean
      {
         return _doubleSpeed;
      }
      
      public function set doubleSpeed(param1:Boolean) : void
      {
         if(_doubleSpeed == param1)
         {
            return;
         }
         _doubleSpeed = param1;
         playbackSpeed = !!param1?3:1;
      }
   }
}
