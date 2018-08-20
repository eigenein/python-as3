package game.view.popup.arena
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.controls.LayoutGroup;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanIconWithFrameClip;
   import game.model.GameModel;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import idv.cjcat.signals.Signal;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class ArenaEnemyPanelClip extends GuiClipNestedContainer
   {
       
      
      private var initialBounds:Rectangle;
      
      private var _signal_pick:Signal;
      
      public const signal_mouseOver:Signal = new Signal();
      
      public var button_attack:ClipButtonLabeled;
      
      public var tf_label_place:ClipLabel;
      
      public var tf_label_power:ClipLabel;
      
      public var tf_place:ClipLabel;
      
      public var tf_power:ClipLabel;
      
      public var tf_nickname:ClipLabel;
      
      public var tf_not_available:ClipLabel;
      
      public var player_portrait:PlayerPortraitClip;
      
      public var clan_icon:ClanIconWithFrameClip;
      
      public var layout_icon:ClipLayout;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      private var _data:PlayerArenaEnemy;
      
      public function ArenaEnemyPanelClip()
      {
         _signal_pick = new Signal(PlayerArenaEnemy);
         button_attack = new ClipButtonLabeled();
         tf_label_place = new ClipLabel();
         tf_label_power = new ClipLabel();
         tf_place = new ClipLabel();
         tf_power = new ClipLabel();
         tf_nickname = new ClipLabel();
         tf_not_available = new ClipLabel();
         player_portrait = new PlayerPortraitClip();
         clan_icon = new ClanIconWithFrameClip();
         layout_icon = ClipLayout.horizontalMiddleCentered(4,player_portrait,clan_icon);
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      public function get signal_pick() : Signal
      {
         return _signal_pick;
      }
      
      public function get data() : PlayerArenaEnemy
      {
         return _data;
      }
      
      public function set data(param1:PlayerArenaEnemy) : void
      {
         if(_data)
         {
            _data.isAvailableByRange.unsubscribe(handler_isAvailableByRange);
         }
         if(param1 && !_data)
         {
            graphics.alpha = 0;
            Starling.juggler.tween(graphics,0.3,{
               "alpha":1,
               "transition":"easeOut"
            });
         }
         _data = param1;
         graphics.visible = _data;
         if(_data)
         {
            _data.isAvailableByRange.onValue(handler_isAvailableByRange);
            tf_place.text = String(_data.place);
            tf_power.text = String(_data.power);
            tf_nickname.text = _data.nickname;
            player_portrait.setData(_data);
            clan_icon.setData(_data.clanInfo,false);
         }
         else
         {
            player_portrait.setData(null);
            clan_icon.setData(null,false);
         }
         if(GameModel.instance.player.arena.rankingIsLocked)
         {
            tf_place.visible = false;
            tf_label_place.visible = false;
         }
         else
         {
            tf_place.visible = true;
            tf_label_place.visible = true;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         initialBounds = graphics.getBounds(graphics);
         initialBounds.x = graphics.x;
         initialBounds.y = graphics.y;
         tf_label_place.text = Translate.translate("UI_DIALOG_ARENA_PLACE");
         tf_label_power.text = Translate.translate("UI_DIALOG_ARENA_POWER");
         button_attack.label = Translate.translate("UI_DIALOG_ARENA_ATTACK");
         tf_not_available.text = Translate.translate("UI_DIALOG_ARENA_ENEMY_NOT_AVAILABLE");
         var _loc3_:LayoutGroup = new LayoutGroup();
         player_portrait.graphics.parent.addChildAt(_loc3_,player_portrait.graphics.parent.getChildIndex(player_portrait.graphics));
         _loc3_.addChild(player_portrait.graphics);
         var _loc2_:Rectangle = player_portrait.graphics.getBounds(player_portrait.graphics);
         _loc3_.width = _loc2_.width + _loc2_.x * 2;
         _loc3_.height = _loc2_.height + _loc2_.y * 2;
         player_portrait.graphics.x = -_loc2_.x;
         player_portrait.graphics.y = -_loc2_.y;
         button_attack.signal_click.add(handler_buttonClick);
         button_attack.graphics.addEventListener("touch",handler_buttonMouseOver);
      }
      
      public function turnOff() : void
      {
         setDisabled(true);
      }
      
      public function setDataWithDelay(param1:PlayerArenaEnemy, param2:Number) : void
      {
         newData = param1;
         delay = param2;
         Starling.juggler.delayCall(function():*
         {
            data = newData;
            setDisabled(false);
         },delay);
      }
      
      protected function setDisabled(param1:Boolean) : void
      {
         button_attack.isEnabled = !param1;
         Starling.juggler.removeTweens(this);
         Starling.juggler.tween(this,0.4,{
            "elementsAlphaValue":(!!param1?0:1),
            "transition":"easeOut"
         });
         AssetStorage.rsx.popup_theme.setDisabledFilter(graphics,param1);
      }
      
      public function get elementsAlphaValue() : Number
      {
         return tf_nickname.alpha;
      }
      
      public function set elementsAlphaValue(param1:Number) : void
      {
         var _loc2_:* = NaN;
         var _loc3_:* = 0.25 + 0.75 * param1;
         tf_power.alpha = _loc3_;
         _loc3_ = _loc3_;
         tf_place.alpha = _loc3_;
         _loc3_ = _loc3_;
         tf_label_power.alpha = _loc3_;
         _loc3_ = _loc3_;
         tf_label_place.alpha = _loc3_;
         _loc3_ = _loc3_;
         PopupBG_12_12_12_12_inst0.graphics.alpha = _loc3_;
         tf_nickname.alpha = _loc3_;
         if(!(graphics.parent is LayoutGroup))
         {
            _loc2_ = 0.05;
            _loc3_ = 1 - _loc2_ + param1 * _loc2_;
            graphics.scaleY = _loc3_;
            graphics.scaleX = _loc3_;
            graphics.x = initialBounds.x + initialBounds.width * 0.5 * (1 - param1) * _loc2_;
            graphics.y = initialBounds.y + initialBounds.height * 0.5 * (1 - param1) * _loc2_;
         }
      }
      
      private function handler_buttonClick() : void
      {
         if(data)
         {
            _signal_pick.dispatch(data);
         }
      }
      
      private function handler_isAvailableByRange(param1:Boolean) : void
      {
         if(!GameModel.instance.player.arena.rankingIsLocked)
         {
            if(param1)
            {
               tf_place.text = String(_data.place);
            }
            else
            {
               tf_place.text = "?";
            }
         }
         Starling.juggler.removeTweens(this);
         setDisabled(!param1);
         tf_not_available.alpha = 0.5;
         button_attack.graphics.visible = param1;
         tf_not_available.visible = !param1;
      }
      
      private function handler_buttonMouseOver(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(param1.currentTarget as DisplayObject,"hover");
         if(_loc2_)
         {
            signal_mouseOver.dispatch();
         }
      }
   }
}
