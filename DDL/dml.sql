INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(1, 'Cadastro Cliente', 'frmCadCliente', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(2, 'Cadastro Produto', 'frmCadProduto', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(3, 'Forma Pagamento', 'frmCadFormaPagamento', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(4, 'Condição Pagamento', 'frmCadCondPgto', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(5, 'Tabela Preco', 'frmcadTabelaPreco', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(6, 'Tabela Preco Produto', 'frmCadTabelaPrecoProduto', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(7, 'Consulta de Produto', 'frmConsultaProdutos', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(8, 'Pedido de Venda', 'frmPedidoVenda', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(9, 'Visualizar Pedido de Venda', 'frmVisualizaPedidoVenda', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(10, 'Edição Pedido de Venda', 'frmEdicaoPedidoVenda', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(11, 'Relatorio Venda Diária', 'frmRelVendaDiaria', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(12, 'Lançamento Nota de Entrada', 'frmLancamentoNotaEntrada', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(13, 'Cadastro Tributação Produto', 'frmCadastraTributacaoItem', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(14, 'Configurações', 'frmConfiguracoes', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(15, 'Cadastro Usuário', 'frmUsuario', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario) VALUES(16, 'Controle de Acesso', 'frmControleAcesso', now());
INSERT INTO public.acoes_sistema (cd_acao, nm_acao, nm_formulario ) VALUES(17, 'Cadastro Endereços', 'frmCadastroEnderecos', now());


insert into login_usuario (id_usuario, login, senha) values (1, 'admin', '');

INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 1, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 2, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 3, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 4, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 5, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 6, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 7, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 8, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 9, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 10, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 11, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 12, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 13, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 14, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 15, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 16, true, true);
INSERT INTO public.usuario_acao (cd_usuario, cd_acao, fl_permite_acesso, fl_permite_edicao) VALUES(1, 17, true, true);


INSERT INTO public.configuracao (cd_configuracao, nm_configuracao, descricao_configuracao, valor) VALUES(2, 'Alterar Forma/Condição na Edição Pedido de Venda', 'Se ativa, permite alterar a forma e condição de pagamento na edição do pedido de venda', 'N');
INSERT INTO public.configuracao (cd_configuracao, nm_configuracao, descricao_configuracao, valor) VALUES(1, 'Alterar Cliente na Edição Pedido de Venda', 'Se ativa, permite alterar o Cliente na edição do pedido de venda', 'N');


INSERT INTO public.modelo_nota_fiscal (cd_modelo, nm_modelo) VALUES('01', 'Nota Fiscal');
INSERT INTO public.operacao (cd_operacao, nm_operacao, fl_ent_sai, cd_modelo_nota_fiscal) VALUES(1, 'Compra', 'E', '01');
INSERT INTO public.serie_nf (cd_serie, nr_serie, descricao, cd_modelo_nota_fiscal) VALUES(1, '1', 'Serie', NULL);