package game.view.popup.fightresult.pve
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.DialogBattleDefeatAsset;
   import game.mediator.gui.popup.mission.MissionDefeatPopupAdviceValueObject;
   import game.mediator.gui.popup.mission.MissionDefeatPopupMediator;
   import game.mediator.gui.popup.socialgrouppromotion.SocialGroupPromotionFactory;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.IPopupSideBarBlock;
   import game.view.popup.common.PopupSideBar;
   import game.view.popup.fightresult.pve.defeatpopuprenderers.ImprovementRenderer;
   import starling.display.Image;
   
   public class MissionDefeatPopup extends ClipBasedPopup
   {
       
      
      private var rays:Image;
      
      private var mediator:MissionDefeatPopupMediator;
      
      private var clip:MissionDefeatPopupClip;
      
      private var sideBar:PopupSideBar;
      
      public function MissionDefeatPopup(param1:MissionDefeatPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         AssetStorage.instance.globalLoader.cancelCallback(_initialize);
         if(clip)
         {
            clip.dispose();
         }
         if(sideBar)
         {
            sideBar.dispose();
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         AssetStorage.instance.globalLoader.requestAssetWithCallback(AssetStorage.rsx.dialog_battle_defeat,_initialize);
      }
      
      private function _initialize(param1:DialogBattleDefeatAsset) : void
      {
         mediator.action_createAdviceList();
         clip = param1.create_dialog_defeat();
         addChild(clip.graphics);
         width = int(clip.bounds_layout_container.graphics.width);
         height = int(clip.bounds_layout_container.graphics.height);
         if(mediator.timeIsUp)
         {
            clip.tf_label_header.text = Translate.translate("UI_DIALOG_MISSION_OUT_OF_TIME");
         }
         else
         {
            clip.tf_label_header.text = Translate.translate("UI_DIALOG_MISSION_DEFEAT");
         }
         var _loc2_:MissionDefeatPopupAdviceValueObject = mediator.randomAdvice;
         var _loc3_:ImprovementRenderer = _loc2_.renderer;
         _loc3_.button_stats.signal_click.add(_loc2_.action);
         clip.layout_main.addChild(_loc3_.graphics);
         clip.button_stats_inst0.label = Translate.translate("UI_DIALOG_MISSION_REWARD_STATS");
         clip.okButton.label = Translate.translate("UI_DIALOG_MISSION_REWARD_FINISH_BUTTON");
         clip.okButton.signal_click.add(close);
         clip.button_stats_inst0.signal_click.add(mediator.action_showStats);
         height = clip.okButton.graphics.y + clip.okButton.graphics.height;
         var _loc4_:IPopupSideBarBlock = SocialGroupPromotionFactory.battleDefeat(mediator.mechanicsType);
         if(_loc4_)
         {
            sideBar = new PopupSideBar(this);
            sideBar.setBlock(_loc4_);
            addChild(sideBar.graphics);
         }
      }
   }
}
