package game.view.popup.titanarena
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class TitanArenaCupRewardsTitlesClip extends GuiClipNestedContainer
   {
       
      
      public var tf_place:ClipLabel;
      
      public var tf_rewards:ClipLabel;
      
      public function TitanArenaCupRewardsTitlesClip()
      {
         tf_place = new ClipLabel();
         tf_rewards = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_place.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_PLACE");
         tf_rewards.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_REWARDS");
         tf_place.validate();
         tf_rewards.validate();
      }
   }
}
