package game.view.popup.friends.socialquest
{
   import com.progrestar.framework.ares.core.Node;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeledGlow;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class SocialQuestPopupClip extends PopupClipBase
   {
       
      
      public var button_farm:ClipButtonLabeledGlow;
      
      public var tf_gem_amount:ClipLabel;
      
      public var task_1:SocialQuestPopupTaskPanel;
      
      public var task_2:SocialQuestPopupTaskPanel;
      
      public var task_3:SocialQuestPopupTaskPanel;
      
      public var task_4:SocialQuestPopupTaskPanel;
      
      public var reward_block:SocialQuestRewardBlock;
      
      public var layout_main:ClipLayout;
      
      public function SocialQuestPopupClip()
      {
         button_farm = new ClipButtonLabeledGlow();
         tf_gem_amount = new ClipLabel();
         task_1 = new SocialQuestPopupTaskPanel();
         task_2 = new SocialQuestPopupTaskPanel();
         task_3 = new SocialQuestPopupTaskPanel();
         task_4 = new SocialQuestPopupTaskPanel();
         reward_block = new SocialQuestRewardBlock();
         layout_main = ClipLayout.verticalCenter(8,task_1,task_2,task_3,task_4,tf_gem_amount);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_main.addChild(reward_block.graphics);
         layout_main.addChild(button_farm.graphics);
         layout_main.height = NaN;
      }
      
      public function resize() : void
      {
         layout_main.validate();
         dialog_frame.graphics.height = layout_main.height + 66;
         bg.graphics.height = layout_main.height + 41;
      }
   }
}
