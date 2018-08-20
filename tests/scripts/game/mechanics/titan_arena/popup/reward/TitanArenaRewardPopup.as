package game.mechanics.titan_arena.popup.reward
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import engine.core.clipgui.GuiAnimation;
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.data.reward.RewardData;
   import game.mechanics.titan_arena.mediator.reward.TitanArenaRewardPopupMediator;
   import game.mechanics.titan_arena.model.TitanArenaHallOfFameVO;
   import game.mechanics.titan_arena.popup.halloffame.TitanArenaHallOfFameBestPlayerRenderer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.GameLabel;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   import game.view.popup.theme.LabelStyle;
   
   public class TitanArenaRewardPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:TitanArenaRewardPopupMediator;
      
      private var clip:TitanArenaRewardPopupClip;
      
      private var _progressAsset:RequestableAsset;
      
      public function TitanArenaRewardPopup(param1:TitanArenaRewardPopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_titan_arena);
         this.mediator = param1;
         this.mediator.signal_infoUpdate.add(handler_infoUpdate);
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.dialog_titan_arena);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override public function dispose() : void
      {
         mediator.signal_infoUpdate.remove(handler_infoUpdate);
         super.dispose();
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         super.onAssetLoaded(param1);
         clip = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaRewardPopupClip,"titan_arena_reward_popup");
         addChild(clip.graphics);
         width = 700;
         height = 400;
         clip.ribbon.container.visible = false;
         clip.content_container.visible = false;
         mediator.action_getHallOfFameInfo();
      }
      
      private function addText(param1:GameLabel, param2:String) : void
      {
         param1.width = clip.content_container.width;
         param1.text = param2;
         clip.content_container.addChild(param1);
      }
      
      private function addCupAnimation(param1:String) : void
      {
         var _loc2_:LayoutGroup = new LayoutGroup();
         _loc2_.height = 230;
         clip.content_container.addChild(_loc2_);
         var _loc3_:GuiAnimation = AssetStorage.rsx.dialog_titan_arena.create(GuiAnimation,param1);
         _loc2_.addChild(_loc3_.graphics);
      }
      
      private function handler_infoUpdate(param1:TitanArenaHallOfFameVO) : void
      {
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = 0;
         var _loc5_:* = 0;
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc13_:* = 0;
         var _loc9_:ClipButtonLabeled = null;
         if(!mediator.trophyWithNotFarmedReward.championRewardFarmed && mediator.trophyWithNotFarmedReward.hasChampionReward)
         {
            height = !!mediator.trophyWithNotFarmedReward.hasCup?570:Number(350);
            clip.ribbon.tf_header.text = Translate.translate("UI_DIALOG_TITAN_ARENA_REWARD_TITLE");
            addText(LabelStyle.createLabel(18,16770485,"center"),Translate.translateArgs("UI_DIALOG_TITAN_ARENA_REWARD_RESULT",mediator.trophyWithNotFarmedReward.place));
            if(mediator.trophyWithNotFarmedReward.hasCup)
            {
               addText(LabelStyle.createLabel(24,15919178,"center"),Translate.translate("LIB_TITAN_ARENA_CUP_" + mediator.trophyWithNotFarmedReward.cup));
               addCupAnimation("cup_" + mediator.trophyWithNotFarmedReward.cup + "_animation_with_bg");
            }
            else
            {
               addText(LabelStyle.createLabel(24,15919178,"center"),Translate.translate("UI_DIALOG_TITAN_ARENA_REWARD_REWARD"));
            }
            _loc4_ = new LayoutGroup();
            _loc4_.layout = new HorizontalLayout();
            (_loc4_.layout as HorizontalLayout).gap = 10;
            clip.content_container.addChild(_loc4_);
            _loc7_ = 0;
            while(_loc7_ < mediator.trophyWithNotFarmedReward.championReward.outputDisplay.length)
            {
               _loc10_ = AssetStorage.rsx.popup_theme.create(InventoryItemRenderer,"inventory_tile");
               _loc10_.setData(mediator.trophyWithNotFarmedReward.championReward.outputDisplay[_loc7_]);
               _loc4_.addChild(_loc10_.container);
               _loc7_++;
            }
            _loc9_ = AssetStorage.rsx.popup_theme.create(ClipButtonLabeled,"green_labeled_button_180");
            _loc9_.label = Translate.translate("UI_DIALOG_TITAN_ARENA_REWARD_FARM");
            clip.content_container.addChild(_loc9_.container);
         }
         else if(!mediator.trophyWithNotFarmedReward.serverRewardFarmed && mediator.trophyWithNotFarmedReward.hasServerReward)
         {
            clip.ribbon.tf_header.text = Translate.translate("UI_DIALOG_TITAN_ARENA_REWARD_BEST_ON_SERVER");
            addText(LabelStyle.createLabel(18,16770485,"center"),mediator.serverName);
            _loc11_ = new TitanArenaHallOfFameBestPlayerRenderer();
            _loc11_.data = param1.bestOnServer;
            clip.content_container.addChild(_loc11_);
            _loc4_ = new LayoutGroup();
            _loc4_.layout = new HorizontalLayout();
            (_loc4_.layout as HorizontalLayout).gap = 10;
            clip.content_container.addChild(_loc4_);
            _loc7_ = 0;
            while(_loc7_ < mediator.trophyWithNotFarmedReward.serverReward.outputDisplay.length)
            {
               _loc10_ = AssetStorage.rsx.popup_theme.create(InventoryItemRenderer,"inventory_tile");
               _loc10_.setData(mediator.trophyWithNotFarmedReward.serverReward.outputDisplay[_loc7_]);
               _loc4_.addChild(_loc10_.container);
               _loc7_++;
            }
            _loc9_ = AssetStorage.rsx.popup_theme.create(ClipButtonLabeled,"green_labeled_button_180");
            _loc9_.label = Translate.translate("UI_DIALOG_TITAN_ARENA_REWARD_FARM");
            clip.content_container.addChild(_loc9_.container);
         }
         else if(!mediator.trophyWithNotFarmedReward.clanRewardFarmed && mediator.trophyWithNotFarmedReward.hasClanReward)
         {
            clip.ribbon.tf_header.text = Translate.translate("UI_DIALOG_TITAN_ARENA_REWARD_BEST_GUILD_MEMBERS");
            addText(LabelStyle.createLabel(18,16770485,"center",true),Translate.translateArgs("UI_DIALOG_TITAN_ARENA_REWARD_BEST_GUILD_MEMBERS_DESC",mediator.clanName));
            _loc12_ = uint(0);
            _loc5_ = uint(3);
            _loc8_ = 0;
            while(_loc8_ < param1.bestGuildMembers.length)
            {
               _loc2_ = mediator.getClanRewardByMemberId(param1.bestGuildMembers[_loc8_].id);
               if(_loc2_)
               {
                  _loc3_ = new LayoutGroup();
                  _loc3_.layout = new HorizontalLayout();
                  (_loc3_.layout as HorizontalLayout).gap = 10;
                  (_loc3_.layout as HorizontalLayout).verticalAlign = "middle";
                  clip.content_container.addChild(_loc3_);
                  _loc6_ = new TitanArenaHallOfFameBestPlayerRenderer();
                  _loc6_.data = param1.bestGuildMembers[_loc8_];
                  _loc3_.addChild(_loc6_);
                  _loc10_ = AssetStorage.rsx.popup_theme.create(InventoryItemRenderer,"inventory_tile");
                  _loc10_.setData(_loc2_.outputDisplayFirst);
                  _loc3_.addChild(_loc10_.container);
                  _loc12_++;
                  if(_loc12_ >= _loc5_)
                  {
                     break;
                  }
               }
               _loc8_++;
            }
            _loc13_ = uint(mediator.getClanRewardsCount());
            if(_loc13_ > _loc12_)
            {
               _loc9_ = AssetStorage.rsx.popup_theme.create(ClipButtonLabeled,"green_labeled_button_220");
               _loc9_.label = Translate.translateArgs("UI_DIALOG_TITAN_ARENA_REWARD_FARM2",_loc13_ - _loc12_);
               clip.content_container.addChild(_loc9_.container);
            }
            else
            {
               _loc9_ = AssetStorage.rsx.popup_theme.create(ClipButtonLabeled,"green_labeled_button_180");
               _loc9_.label = Translate.translate("UI_DIALOG_TITAN_ARENA_REWARD_FARM");
               clip.content_container.addChild(_loc9_.container);
            }
            height = 350 + _loc12_ * 50;
         }
         clip.ribbon.container.visible = true;
         clip.content_container.visible = true;
         if(_loc9_)
         {
            _loc9_.signal_click.add(mediator.action_farm);
         }
      }
   }
}
