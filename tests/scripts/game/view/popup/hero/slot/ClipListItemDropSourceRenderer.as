package game.view.popup.hero.slot
{
   import game.assets.storage.AssetStorage;
   import game.data.storage.pve.mission.MissionItemDropValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   
   public class ClipListItemDropSourceRenderer extends ListItemRenderer
   {
       
      
      private var mediator:ClipListItemDropSourceRendererMediator;
      
      private var clip:ClipListItemDropSourceRendererClip;
      
      protected var _signal_select:Signal;
      
      public function ClipListItemDropSourceRenderer()
      {
         _signal_select = new Signal(MissionItemDropValueObject);
         super();
         mediator = new ClipListItemDropSourceRendererMediator();
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         mediator.dispose();
         clip.dispose();
         clip.button.signal_click.remove(handler_click);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClipListItemDropSourceRendererClip,"hero_slot_drop_sources_item");
         clip.mediator = mediator;
         addChild(clip.graphics);
         clip.button.signal_click.add(handler_click);
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         mediator.setData(data);
      }
      
      private function handler_click() : void
      {
         _signal_select.dispatch(data as MissionItemDropValueObject);
      }
   }
}
