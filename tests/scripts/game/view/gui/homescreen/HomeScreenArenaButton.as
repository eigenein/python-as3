package game.view.gui.homescreen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import game.mediator.gui.popup.arena.ArenaPopupMediator;
   import game.view.gui.tutorial.ITutorialButtonBoundsProvider;
   
   public class HomeScreenArenaButton extends HomeScreenBuildingButton implements ITutorialButtonBoundsProvider
   {
       
      
      public var icon_content:GuiAnimation;
      
      public function HomeScreenArenaButton()
      {
         super();
      }
      
      public function get tutorialButtonOffsetX() : Number
      {
         return 0;
      }
      
      public function get tutorialButtonOffsetY() : Number
      {
         return 10;
      }
      
      public function get tutorialButtonRadius() : Number
      {
         return 150;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:Boolean = false;
         hover_front.graphics.touchable = _loc2_;
         icon_content.graphics.touchable = _loc2_;
      }
      
      override protected function createHoverSound() : ButtonHoverSound
      {
         return ArenaPopupMediator.music;
      }
   }
}
