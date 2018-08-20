package game.battle.view.hero
{
   import avmplus.getQualifiedClassName;
   import engine.core.animation.DisposableAnimation;
   import engine.core.animation.IDisposableAnimationContainer;
   import engine.core.animation.ZSortedSprite;
   import idv.cjcat.signals.Signal;
   
   public class HeroViewContainer implements IHeroViewContainer, IDisposableAnimationContainer
   {
       
      
      private const onChildrenDisposed:Signal = new Signal(HeroView);
      
      protected const children:Vector.<HeroView> = new Vector.<HeroView>();
      
      private var childrenIterationIndex:int = 0;
      
      protected const heroesContainer:ZSortedSprite = new ZSortedSprite();
      
      private var _scale:Number = 1;
      
      private var _isoScale:Number = 0.5;
      
      public function HeroViewContainer()
      {
         super();
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function get isoScale() : Number
      {
         return _isoScale;
      }
      
      public function addHero(param1:HeroView) : void
      {
         param1.addToParent(heroesContainer,this);
         param1.addOnDispose(this);
         children.push(param1);
      }
      
      public function removeHero(param1:HeroView) : void
      {
         param1.transform.removeFromParent();
      }
      
      public function handleRemovedChild(param1:DisposableAnimation) : void
      {
         var _loc3_:int = 0;
         var _loc2_:HeroView = param1 as HeroView;
         if(_loc2_ != null)
         {
            _loc3_ = children.indexOf(_loc2_);
            if(_loc3_ == -1)
            {
               return;
               §§push(trace(getQualifiedClassName(this),"onChildrenDisposedHandeler","logic error"));
            }
            else
            {
               if(_loc3_ < childrenIterationIndex)
               {
                  childrenIterationIndex = Number(childrenIterationIndex) - 1;
               }
               children.splice(_loc3_,1);
            }
         }
      }
      
      public function resortContainer() : void
      {
         heroesContainer.resortChildren();
      }
      
      protected function advanceHeroesTime(param1:Number) : void
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
