package game.data.storage.tutorial
{
   import game.data.storage.DescriptionBase;
   
   public class TutorialDescription extends DescriptionBase
   {
       
      
      public const chains:Vector.<TutorialTaskChainDescription> = new Vector.<TutorialTaskChainDescription>();
      
      public function TutorialDescription(param1:*)
      {
         super();
         _name = param1.ident;
         _id = param1.id;
      }
      
      function addChain(param1:TutorialTaskChainDescription) : void
      {
         chains.push(param1);
      }
   }
}
