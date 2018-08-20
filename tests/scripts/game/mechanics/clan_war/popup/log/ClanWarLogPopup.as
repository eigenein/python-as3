package game.mechanics.clan_war.popup.log
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.clan_war.mediator.log.ClanWarLogPopupMediator;
   import game.view.popup.AsyncClipBasedPopup;
   import starling.events.Event;
   
   public class ClanWarLogPopup extends AsyncClipBasedPopup
   {
       
      
      private var mediator:ClanWarLogPopupMediator;
      
      private var clip:ClanWarLogPopupClip;
      
      public function ClanWarLogPopup(param1:ClanWarLogPopupMediator)
      {
         super(param1,AssetStorage.rsx.clan_war_map);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.logs.removeEventListener("change",handler_dataChange);
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(ClanWarLogPopupClip,"popup_clan_war_log");
         addChild(clip.graphics);
         centerPopupBy(clip.dialog_frame.graphics,0,15);
         clip.title = Translate.translate("UI_DIALOG_LOG_CLANWAR_NAME");
         clip.tf_message.text = Translate.translate("UI_DIALOG_LOG_ARENA_EMPTY");
         clip.button_close.signal_click.add(mediator.close);
         var _loc2_:VerticalLayout = new VerticalLayout();
         _loc2_.gap = 6;
         _loc2_.paddingTop = 0;
         _loc2_.paddingBottom = 20;
         _loc2_.useVirtualLayout = false;
         clip.list.layout = _loc2_;
         clip.list.itemRendererType = ClanWarLogItemRenderer;
         clip.list.dataProvider = mediator.logs;
         mediator.logs.addEventListener("change",handler_dataChange);
         handler_dataChange(null);
      }
      
      private function handler_dataChange(param1:Event) : void
      {
         if(mediator.logs.length == 0)
         {
            clip.tf_message.visible = true;
         }
         else
         {
            clip.tf_message.visible = false;
            clip.list.scrollToDisplayIndex(Math.max(0,mediator.logs.length - 3),0);
            clip.list.scrollToDisplayIndex(mediator.logs.length - 1,0.7);
         }
      }
   }
}
