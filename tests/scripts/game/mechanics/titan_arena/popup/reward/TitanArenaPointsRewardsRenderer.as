package game.mechanics.titan_arena.popup.reward
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.data.reward.RewardData;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TitanArenaPointsRewardsRenderer extends GuiClipNestedContainer
   {
       
      
      public var tf_text:ClipLabel;
      
      public var text_layout:ClipLayout;
      
      public var tf_rewards:ClipLabel;
      
      public var rewards_layout:ClipLayout;
      
      public var rewards_v_layout:ClipLayout;
      
      public var action_button:ClipButtonLabeled;
      
      public function TitanArenaPointsRewardsRenderer()
      {
         tf_text = new ClipLabel();
         text_layout = ClipLayout.horizontalMiddleCentered(0,tf_text);
         tf_rewards = new ClipLabel();
         rewards_layout = ClipLayout.horizontalMiddleCentered(10);
         rewards_v_layout = ClipLayout.verticalMiddleCenter(-5,rewards_layout,tf_rewards);
         action_button = new ClipButtonLabeled();
         super();
      }
      
      public function setData(param1:String, param2:RewardData) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         tf_text.text = param1;
         _loc3_ = 0;
         while(_loc3_ < param2.outputDisplay.length)
         {
            _loc4_ = AssetStorage.rsx.popup_theme.create(TitanArenaRewardItemRenderer,"quest_reward_item");
            _loc4_.data = param2.outputDisplay[_loc3_];
            rewards_layout.addChild(_loc4_.container);
            _loc3_++;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_rewards.text = Translate.translate("UI_DIALOG_TITAN_ARENA_POINTS_REWARD_EVERY_VICTORY");
      }
   }
}
