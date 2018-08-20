package game.view.popup.hero.rune
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.rune.PlayerHeroRuneMediator;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import idv.cjcat.signals.Signal;
   
   public class HeroPopupRuneTab extends GuiClipNestedContainer
   {
       
      
      private var _mediator:PlayerHeroRuneMediator;
      
      public var rune:Vector.<RuneItemClipWithHint>;
      
      public var button_go:ClipButtonLabeled;
      
      public var tf_label:ClipLabel;
      
      public const signal_go:Signal = new Signal();
      
      public function HeroPopupRuneTab()
      {
         rune = new Vector.<RuneItemClipWithHint>();
         button_go = new ClipButtonLabeled();
         tf_label = new ClipLabel();
         super();
      }
      
      public function set mediator(param1:PlayerHeroRuneMediator) : void
      {
         if(_mediator)
         {
            _mediator.signal_updated.remove(handler_update);
         }
         this._mediator = param1;
         if(_mediator)
         {
            _mediator.signal_updated.add(handler_update);
            handler_update();
         }
         else
         {
            clear();
         }
         button_go.graphics.visible = false;
         if(_mediator == null || !_mediator.runesEnabled)
         {
            tf_label.text = Translate.translate("UI_DIALOG_HERO_RUNE_NOT_ENABLED");
         }
         else if(!_mediator.runesAvailableByTeamLevel)
         {
            tf_label.text = Translate.translateArgs("UI_DIALOG_HERO_RUNE_NOT_ENOUGH_TEAM_LEVEL",_mediator.availableFromTeamLevel);
         }
         else if(!_mediator.runesAvailable)
         {
            tf_label.text = Translate.translate("UI_DIALOG_HERO_RUNE_NO_GUILD");
            button_go.graphics.visible = true;
            button_go.label = Translate.translate("UI_DIALOG_HERO_RUNE_GO_GUILD");
         }
         else
         {
            tf_label.text = Translate.translate("UI_DIALOG_HERO_RUNE_DESCRIPTION");
            button_go.graphics.visible = true;
            button_go.label = Translate.translate("UI_DIALOG_HERO_RUNE_GO");
         }
      }
      
      public function update() : void
      {
         handler_update();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_go.initialize("",signal_go.dispatch);
      }
      
      private function clear() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_update() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
