package game.view.popup.activity
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.LayoutGroup;
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.dailybonus.DailyBonusValueObject;
   import game.view.popup.dailybonus.DailyBonusPopupTile;
   import starling.events.Event;
   
   public class DailyBonusView extends LayoutGroup
   {
       
      
      private var clip:DailyBonusViewClip;
      
      private var mediator:DailyBonusMediator;
      
      private var stashParams:PopupStashEventParams;
      
      public function DailyBonusView(param1:DailyBonusMediator, param2:PopupStashEventParams)
      {
         super();
         this.mediator = param1;
         this.stashParams = param2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.signal_update.remove(handler_dailBonusUpdate);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_view_daily_bonus();
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         mediator.signal_update.add(handler_dailBonusUpdate);
         handler_dailBonusUpdate();
         clip.gradient_top.graphics.visible = false;
         clip.gradient_bottom.graphics.visible = false;
         clip.list_container.itemRendererType = DailyBonusPopupTile;
         clip.list_container.addEventListener("rendererAdd",onListRendererAdded);
         clip.list_container.addEventListener("rendererRemove",onListRendererRemoved);
         var _loc1_:Vector.<DailyBonusValueObject> = mediator.getItems();
         clip.list_container.dataProvider = new ListCollection(_loc1_);
         clip.list_container.scrollToDisplayIndex(mediator.activeItemIndex);
      }
      
      private function onListRendererAdded(param1:Event, param2:DailyBonusPopupTile) : void
      {
         param2.signal_farm.add(handler_farm);
      }
      
      private function onListRendererRemoved(param1:Event, param2:DailyBonusPopupTile) : void
      {
         param2.signal_farm.remove(handler_farm);
      }
      
      private function handler_farm(param1:DailyBonusValueObject) : void
      {
         mediator.action_farm(param1,stashParams);
      }
      
      private function handler_dailBonusUpdate() : void
      {
         clip.tf_caption.text = Translate.translateArgs("UI_DIALOG_DAILYBONUS_FARMED_X",mediator.farmedThisMonthTimes);
      }
   }
}
