package game.view.popup.activity
{
   import game.assets.storage.AssetStorage;
   import game.command.timer.GameTimer;
   import game.view.gui.components.list.ListItemRenderer;
   import idv.cjcat.signals.Signal;
   import starling.display.Image;
   import starling.events.Event;
   
   public class QuestEventListItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:EventListItemRendererClip;
      
      public const signal_select:Signal = new Signal(QuestEventValueObjectBase);
      
      public function QuestEventListItemRenderer()
      {
         super();
         addEventListener("addedToStage",handler_addedToStage);
         addEventListener("removedFromStage",handler_removedFromStage);
      }
      
      override public function dispose() : void
      {
         if(data != null)
         {
            data = null;
         }
         GameTimer.instance.oneSecTimer.remove(updateTime);
         removeEventListener("addedToStage",handler_addedToStage);
         removeEventListener("removedFromStage",handler_removedFromStage);
         super.dispose();
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         if(isSelected == param1)
         {
            return;
         }
         .super.isSelected = param1;
         updateSelection();
         if(param1)
         {
            signal_select.dispatch(data as QuestEventValueObjectBase);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         if(this._data == param1)
         {
            return;
         }
         var _loc2_:QuestEventValueObjectBase = _data as QuestEventValueObjectBase;
         if(_loc2_ != null)
         {
            _loc2_.canFarm.unsubscribe(handler_redDotVisible);
         }
         .super.data = param1;
         _loc2_ = _data as QuestEventValueObjectBase;
         if(_loc2_ != null)
         {
            _loc2_.canFarm.onValue(handler_redDotVisible);
         }
      }
      
      override protected function initialize() : void
      {
         clip = AssetStorage.rsx.popup_theme.create_event_renderer();
         addChild(clip.graphics);
         clip.signal_click.add(handler_click);
         clip.frame_selected.graphics.touchable = false;
         updateSelection();
      }
      
      override protected function commitData() : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:QuestEventValueObjectBase = this.data as QuestEventValueObjectBase;
         if(clip && _loc1_)
         {
            clip.icon_container.container.addChild(new Image(AssetStorage.rsx.event_icons.getTexture(_loc1_.iconAsset)));
            clip.tf_title.text = _loc1_.name;
            clip.tf_title.validate();
            clip.container_title.invalidate();
            clip.container_title.validate();
            clip.title_bg.graphics.y = clip.container_title.y + clip.container_title.height - clip.tf_title.height;
            clip.title_bg.graphics.height = clip.frame.graphics.y + clip.frame.graphics.height - 4 - clip.title_bg.graphics.y;
            clip.title_bg_left.graphics.y = clip.title_bg.graphics.y;
            clip.title_bg_left.graphics.height = clip.title_bg.graphics.height;
            _loc4_ = clip.frame.graphics.x + 4;
            _loc3_ = clip.frame.graphics.x + clip.frame.graphics.width - 4;
            _loc2_ = clip.container_title.x + clip.container_title.width - clip.tf_title.textWidthMultiline + 20;
            if(_loc2_ - 25 < _loc4_)
            {
               _loc2_ = _loc2_ - 10;
            }
            clip.title_bg_left.graphics.x = Math.max(_loc2_ - 100,_loc4_);
            clip.title_bg_left.graphics.width = _loc2_ - clip.title_bg_left.graphics.x;
            clip.title_bg.graphics.x = _loc2_;
            clip.title_bg.graphics.width = _loc3_ - _loc2_;
            updateTime();
         }
      }
      
      private function updateSelection() : void
      {
         if(clip)
         {
            clip.selected_marker.graphics.visible = isSelected;
            clip.frame_selected.graphics.visible = isSelected;
            clip.frame.graphics.visible = !isSelected;
         }
      }
      
      private function updateTime() : void
      {
         var _loc2_:Number = NaN;
         var _loc1_:QuestEventValueObjectBase = this.data as QuestEventValueObjectBase;
         if(clip && _loc1_ && _loc1_.hasEndTime)
         {
            _loc2_ = _loc1_.timeLeft;
            clip.tf_timer.visible = _loc2_ > 0;
            clip.timer_bg.graphics.visible = _loc2_ > 0;
            if(_loc2_ > 0)
            {
               clip.tf_timer.text = _loc1_.timeString;
            }
         }
         else
         {
            clip.tf_timer.visible = false;
            clip.timer_bg.graphics.visible = false;
         }
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         GameTimer.instance.oneSecTimer.add(updateTime);
      }
      
      private function handler_removedFromStage(param1:Event) : void
      {
         GameTimer.instance.oneSecTimer.remove(updateTime);
      }
      
      private function handler_redDotVisible(param1:Boolean) : void
      {
         clip.red_dot.graphics.visible = param1;
      }
      
      private function handler_click() : void
      {
         isSelected = true;
      }
   }
}
