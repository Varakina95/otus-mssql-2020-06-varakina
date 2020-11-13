CREATE PROCEDURE Sales.ConfirmInvoice
AS
BEGIN
	--Receiving Reply Message from the Target.	
	DECLARE @InitiatorReplyDlgHandle UNIQUEIDENTIFIER, --хэндл диалога
			@ReplyReceivedMessage NVARCHAR(1000) 
	
	BEGIN TRAN; 

	--получим сообщение из очереди инициатора
		RECEIVE TOP(1)
			@InitiatorReplyDlgHandle=Conversation_Handle
			,@ReplyReceivedMessage=Message_Body
		FROM dbo.InitiatorQueueWWI; 
		
		END CONVERSATION @InitiatorReplyDlgHandle; --закроем диалог со стороны инициатора
		
		SELECT @ReplyReceivedMessage AS ReceivedRepliedMessage; --в консоль

	COMMIT TRAN; 
END

