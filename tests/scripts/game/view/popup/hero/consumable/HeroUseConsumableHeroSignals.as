package game.view.popup.hero.consumable
{
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.view.gui.components.ClipListItem;
   import idv.cjcat.signals.Signal;
   
   public class HeroUseConsumableHeroSignals
   {
       
      
      public const levelUp:Signal = new Signal(ClipListItem);
      
      public const onScreen:Signal = new Signal(ClipListItem);
      
      public const click:Signal = new Signal(PlayerHeroListValueObject);
      
      public const oneLevelClick:Signal = new Signal(PlayerHeroListValueObject);
      
      public function HeroUseConsumableHeroSignals()
      {
         super();
      }
   }
}
