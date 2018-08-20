package game.mechanics.grand.popup.log
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.MiniHeroTeamRenderer;
   
   public class GrandLogInfoTeamClip extends GuiClipNestedContainer
   {
       
      
      public var tf_defeat:ClipLabel;
      
      public var tf_victory:ClipLabel;
      
      public var team:MiniHeroTeamRenderer;
      
      public function GrandLogInfoTeamClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_defeat.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_DEFEAT");
         tf_victory.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_VICTORY");
      }
   }
}
