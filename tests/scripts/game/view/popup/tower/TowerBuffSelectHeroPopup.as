package game.view.popup.tower
{
   import com.progrestar.common.lang.Translate;
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.tower.TowerBuffSelectHeroPopupMediator;
   import game.mediator.gui.popup.tower.TowerBuffSelectHeroValueObject;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.floatingtext.FloatingTextContainer;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.hero.HeroList;
   import starling.events.Event;
   
   public class TowerBuffSelectHeroPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TowerBuffSelectHeroPopupMediator;
      
      private var list:List;
      
      private var clip:TowerBuffSelectHeroPopupClip;
      
      public function TowerBuffSelectHeroPopup(param1:TowerBuffSelectHeroPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_tower_buff_select_hero_dialog();
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.container.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         list = new HeroList(_loc1_,clip.gradient_top.graphics,clip.gradient_bottom.graphics);
         list.width = clip.team_list_container.graphics.width;
         list.height = clip.team_list_container.graphics.height;
         list.addEventListener("rendererAdd",handler_listRendererAdded);
         list.addEventListener("rendererRemove",handler_listRendererRemoved);
         list.itemRendererType = TowerBuffSelectHeroItemRenderer;
         list.dataProvider = new ListCollection(mediator.heroes);
         clip.team_list_container.layoutGroup.addChild(list);
         clip.button_close.signal_click.add(close);
         clip.tf_use_label.text = Translate.translate("UI_TOWER_BUFF_APPLY");
         clip.tf_item_label.text = mediator.buff.name;
         clip.itemIcon.image.image.texture = mediator.buff.icon;
      }
      
      private function handler_listRendererAdded(param1:Event, param2:TowerBuffSelectHeroItemRenderer) : void
      {
         param2.signal_select.add(handler_heroSelect);
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:TowerBuffSelectHeroItemRenderer) : void
      {
         param2.signal_select.remove(handler_heroSelect);
      }
      
      private function handler_heroSelect(param1:TowerBuffSelectHeroItemRenderer) : void
      {
         var _loc2_:TowerBuffSelectHeroValueObject = param1.data as TowerBuffSelectHeroValueObject;
         if(!_loc2_)
         {
            return;
         }
         mediator.action_selectHero(_loc2_);
         FloatingTextContainer.showInDisplayObjectCenter(param1,0,50,mediator.buff.message,mediator);
         list.isEnabled = false;
      }
   }
}
