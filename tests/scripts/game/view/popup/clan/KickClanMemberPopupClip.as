package game.view.popup.clan
{
   import com.progrestar.framework.ares.core.Node;
   import game.view.gui.components.CheckBoxLabeledGuiToggleButton;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.PromptPopupClip;
   
   public class KickClanMemberPopupClip extends PromptPopupClip
   {
       
      
      public var button_close:ClipButton;
      
      public var check_box:CheckBoxLabeledGuiToggleButton;
      
      public var layout_check_box:ClipLayout;
      
      public function KickClanMemberPopupClip()
      {
         button_close = new ClipButton();
         check_box = new CheckBoxLabeledGuiToggleButton();
         layout_check_box = ClipLayout.horizontalMiddleCentered(4,check_box);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         layout_text.addChild(layout_check_box);
         super.setNode(param1);
      }
   }
}
