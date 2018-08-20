package game.view.popup.titanarena
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.data.reward.RewardData;
   import game.mechanics.titan_arena.popup.reward.TitanArenaRewardItemRenderer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TitanArenaRewardsRenderer extends GuiClipNestedContainer
   {
       
      
      public var tf_text:ClipLabel;
      
      public var rewards_layout:ClipLayout;
      
      public function TitanArenaRewardsRenderer()
      {
         tf_text = new ClipLabel();
         rewards_layout = ClipLayout.horizontalMiddleCentered(10);
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
   }
}
