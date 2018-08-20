package game.view.popup.tower
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.tower.TowerBuffSelectHeroValueObject;
   import game.view.popup.hero.HeroColorNumberClip;
   import game.view.popup.hero.HeroListItemRendererBase;
   import idv.cjcat.signals.Signal;
   import starling.core.Starling;
   
   public class TowerBuffSelectHeroItemRenderer extends HeroListItemRendererBase
   {
       
      
      private var vo:TowerBuffSelectHeroValueObject;
      
      private var colorPlusClip:HeroColorNumberClip;
      
      public const signal_select:Signal = new Signal(TowerBuffSelectHeroItemRenderer);
      
      public function TowerBuffSelectHeroItemRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         clip.bg_button.dispose();
         if(vo)
         {
            vo.signal_tweenState.remove(handler_tweenState);
         }
         super.dispose();
      }
      
      override public function set data(param1:Object) : void
      {
         vo = data as TowerBuffSelectHeroValueObject;
         if(vo)
         {
            vo.signal_tweenState.remove(handler_tweenState);
         }
         .super.data = param1;
         vo = data as TowerBuffSelectHeroValueObject;
         if(vo)
         {
            vo.signal_tweenState.add(handler_tweenState);
            updateNameColor();
            updateState();
         }
      }
      
      protected function get clip() : TowerBuffSelectHeroItemClip
      {
         return assetClip as TowerBuffSelectHeroItemClip;
      }
      
      override protected function createClip() : void
      {
         assetClip = AssetStorage.rsx.popup_theme.create_tower_buff_select_hero_item();
         addChild(assetClip.graphics);
      }
      
      override protected function listener_buttonClick() : void
      {
         signal_select.dispatch(this);
      }
      
      private function updateNameColor() : void
      {
         if(colorPlusClip)
         {
            colorPlusClip.dispose();
         }
         colorPlusClip = HeroColorNumberClip.create(vo.color,true);
         if(colorPlusClip)
         {
            clip.layout_name.addChild(colorPlusClip.graphics);
         }
         clip.tf_hero_name.text = vo.name;
      }
      
      private function updateState() : void
      {
         clip.progressbar_hp.value = vo.relativeHp;
         clip.progressbar_energy.value = vo.relativeEnergy;
         updateDeadState();
         var _loc1_:Boolean = vo.isAvailable;
         isEnabled = _loc1_;
         touchable = _loc1_;
         portrait.disabled = !_loc1_;
      }
      
      private function updateDeadState() : void
      {
         clip.dead.visible = vo.isDead;
         clip.dead.visible = vo.isDead;
         var _loc1_:Number = !!vo.isDead?0.2:1;
         clip.progressbar_hp.graphics.alpha = _loc1_;
         clip.progressbar_energy.graphics.alpha = _loc1_;
      }
      
      private function onDataUpdate() : void
      {
         var _loc1_:TowerBuffSelectHeroValueObject = data as TowerBuffSelectHeroValueObject;
      }
      
      private function handler_tweenState() : void
      {
         updateDeadState();
         Starling.juggler.tween(clip.progressbar_hp,0.8,{
            "delay":0,
            "value":vo.relativeHp
         });
         Starling.juggler.tween(clip.progressbar_energy,0.8,{
            "delay":0,
            "value":vo.relativeEnergy
         });
      }
   }
}
