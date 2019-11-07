function print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    slurm.log_info("printing")
    if(indentLevel == nil) then
        slurm.log_info(print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
        else 
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end

function print_not_null(toPring)
	if  toPrint == nil  then
		slurm.log_info("isNull")
	else
		slurm.log_info(toPrint)
	end
end


--slurm.log_info = function(s,...)
--		           return io.write(s:format(...))
--		            end -- functio


function esc(x)
   return (x:gsub('%%', '%%%%')
            :gsub('^%^', '%%^')
            :gsub('%$$', '%%$')
            :gsub('%(', '%%(')
            :gsub('%)', '%%)')
            :gsub('%.', '%%.')
            :gsub('%[', '%%[')
            :gsub('%]', '%%]')
            :gsub('%*', '%%*')
            :gsub('%+', '%%+')
            :gsub('%-', '%%-')
            :gsub('%?', '%%?'))
end

function slurm_job_submit(job_desc, part_list, submit_uid)
--	if (job_desc.features ~= nil) then
--		job_desc.features = "[xeon|knl]"
--	end
if job_desc.gres ~= nil then
	slurm.log_info("job_submit: job_desc.gres:  %s",job_desc.gres);
	slurm.log_info("job_submit: job_desc.tres_per_node:  %s",job_desc.tres_per_node);
end
if job_desc.tres_per_job ~= nil then
	slurm.log_info("job_submit: job_desc.tres_per_job:  %s",job_desc.tres_per_job);
end
if job_desc.tres_per_socket ~= nil then
	slurm.log_info("job_submit: job_desc.tres_per_socket:  %s",job_desc.tres_per_socket);
end
if job_desc.tres_per_task ~= nil then
	slurm.log_info("job_submit: job_desc.tres_per_task:  %s",job_desc.tres_per_task);
end

--------if (job_desc.tres_per_node ~= nil) then
--------	gres_types = { "test_k20m", "tesla_v100-sxm2-32g" } 

--------	slurm.log_info("job_submit: Submitted tres per node: %s",job_desc.tres_per_node)

--------	local gres_array = {}
--------	for gres_sub in string.gmatch(job_desc.tres_per_node, "([^:]+)") do
--------		table.insert(gres_array, gres_sub)
--------	end
--------	
--------	if gres_array[2] ~= nil then
--------		slurm.log_info("job_submit: gres_type set to %s", gres_array[2])
--------		local new_gres=""
--------		for gres_k, gres_v in pairs(gres_types) do
--------			slurm.log_info("job_submit: Comparing with %s",gres_v)
--------			if string.match(gres_v, esc(gres_array[2])) then
--------				slurm.log_info("job_submit:          MATCHED: %s", gres_v)
--------				if gres_array[3] == nil then
--------					new_gres=string.format("%s:%s",gres_array[1],gres_v)
--------				else
--------					new_gres=string.format("%s:%s:%s",gres_array[1],gres_v,gres_array[3])
--------				end

--------				break
--------			else
--------				slurm.log_info("job_submit:         No match")
--------			end

--------		end
--------		if new_gres ~= "" then
--------			slurm.log_info("job_submit: New tres per node: %s", new_gres)
--------			job_desc.tres_per_node = new_gres
--------		else
--------			slurm.log_info("job_submit: gres_type not matched, leaving untouched")
--------		end
--------	else
--------		slurm.log_info("job_submit: gres_type not specified")
--------		slurm.log_info("job_submit: no tres_per_node")
--------	end

--------end

--------job_desc.admin_comment = "ALA"
--------if job_desc.comment == nil then
--------	slurm.error("Error display");
--------	slurm.log_user("Faled");
--------	return slurm.FAILURE;
--------end


--------if job_desc.tres_per_job ~= nil then
--------	slurm.log_info("per_job")
--------	slurm.log_info(job_desc.tres_per_job)
--------end
--------if job_desc.tres_per_node ~= nil then
--------	slurm.log_info("per_node")
--------	slurm.log_info(job_desc.tres_per_node)
--------end
--	slurm.log_info("per_socket")
--	print_not_null(job_desc.tres_per_socket)
--	slurm.log_info("per_task")
--	print_not_null(job_desc.tres_per_task)

	return 0
end

function slurm_job_modify(job_sec, part_list, submit_uid)
	return 0
end
