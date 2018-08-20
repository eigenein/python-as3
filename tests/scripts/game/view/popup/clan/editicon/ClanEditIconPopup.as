package game.view.popup.clan.editicon
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanEditIconPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class ClanEditIconPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanEditIconPopupMediator;
      
      private const clip:ClanEditIconPopupClip = AssetStorage.rsx.popup_theme.create_dialog_clan_edit_icon();
      
      private var color1:ClanEditIconItemPicker;
      
      private var color2:ClanEditIconItemPicker;
      
      private var color3:ClanEditIconItemPicker;
      
      private var canvas:ClanEditIconItemPicker;
      
      private var emblem:ClanEditIconItemPicker;
      
      private var resultFlag:ClanIconClip;
      
      private var resultIcon:ClanIconClip;
      
      public function ClanEditIconPopup(param1:ClanEditIconPopupMediator)
      {
         this.mediator = param1;
         super(param1);
      }
      
      override public function dispose() : void
      {
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.dialog_frame.graphics.touchable = false;
         if(mediator.showCost)
         {
            clip.cost.costData = mediator.cost;
         }
         else
         {
            clip.cost.graphics.visible = false;
         }
         clip.title = Translate.translate("UI_DIALOG_CLAN_EDIT_ICON_HEADER");
         clip.button_close.signal_click.add(mediator.close);
         clip.button_confirm.initialize(Translate.translate("UI_DIALOG_CLAN_EDIT_ICON_SAVE"),mediator.action_save);
         color1 = new ClanEditIconItemPicker(mediator.colorsDataProvider,mediator.color1,clip.color1.list,clip.color1.button_left,clip.color1.button_right);
         color2 = new ClanEditIconItemPicker(mediator.colorsDataProvider,mediator.color2,clip.color2.list,clip.color2.button_left,clip.color2.button_right);
         color3 = new ClanEditIconItemPicker(mediator.colorsDataProvider,mediator.color3,clip.color3.list,clip.color3.button_left,clip.color3.button_right);
         canvas = new ClanEditIconItemPicker(mediator.canvasDataProvider,mediator.canvas,clip.list_canvas,clip.button_canvas_left,clip.button_canvas_right);
         emblem = new ClanEditIconItemPicker(mediator.emblemDataProvider,mediator.emblem,clip.list_emblem,clip.button_emblem_left,clip.button_emblem_right);
         color1.signal_selected.add(mediator.action_selectColor1);
         color2.signal_selected.add(mediator.action_selectColor2);
         color3.signal_selected.add(mediator.action_selectColor3);
         canvas.signal_selected.add(mediator.action_selectCanvas);
         emblem.signal_selected.add(mediator.action_selectEmblem);
         mediator.signal_canvasUpdated.add(handler_canvasUpdated);
         mediator.signal_emblemUpdated.add(handler_emblemUpdated);
         resultFlag = AssetStorage.rsx.clan_icons.createFlagClip();
         resultIcon = AssetStorage.rsx.clan_icons.createIconClip();
         clip.layout_result.addChild(resultFlag.graphics);
         clip.layout_mini.addChild(resultIcon.graphics);
         updateResult();
      }
      
      private function updateResult() : void
      {
         resultFlag.setupCanvas(mediator.canvas.colorPatternTexture,mediator.color1.color,mediator.color2.color);
         resultFlag.setupIcon(mediator.emblem.emblemTexture,mediator.color3.color);
         resultIcon.setupCanvas(mediator.canvas.squareColorPatternTexture,mediator.color1.color,mediator.color2.color);
         resultIcon.setupIcon(mediator.emblem.emblemTexture,mediator.color3.color);
      }
      
      private function handler_canvasUpdated() : void
      {
         updateResult();
      }
      
      private function handler_emblemUpdated() : void
      {
         updateResult();
      }
   }
}
